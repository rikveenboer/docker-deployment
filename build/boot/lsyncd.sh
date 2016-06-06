#!/bin/bash
set -e
if [ ! -e $LSYNC_CONFIG ]; then
    CSYNC_BIN=`which csync2`
    CSYNC_CONFIG_DIR=`dirname $CSYNC_CONFIG`
    cat << EOF > $LSYNC_CONFIG
settings {
        logident        = "lsyncd",
        logfacility     = "user",
        logfile         = "$LSYNC_LOG",
        statusFile      = "$LSYNC_STATUS",
        statusInterval  = 1
}
initSync = {
        delay = 1,
        maxProcesses = 1,
        action = function(inlet)
                local config = inlet.getConfig()
                local elist = inlet.getEvents(function(event)
                        return event.etype ~= "Init"
                end)
                local directory = string.sub(config.source, 1, -2)
                local paths = elist.getPaths(function(etype, path)
                        return "\t" .. config.syncid .. ":" .. directory .. path
                end)
                log("Normal", "Processing syncing list:\n", table.concat(paths, "\n"))
                spawn(elist, "$CSYNC_BIN", "-C", config.syncid, "-x")
        end,
        collect = function(agent, exitcode)
                local config = agent.config
                if not agent.isList and agent.etype == "Init" then
                        if exitcode == 0 then
                                log("Normal", "Startup of '", config.syncid, "' instance finished.")
                        elseif config.exitcodes and config.exitcodes[exitcode] == "again" then
                                log("Normal", "Retrying startup of '", config.syncid, "' instance.")
                                return "again"
                        else
                                log("Error", "Failure on startup of '", config.syncid, "' instance.")
                                terminate(-1)
                        end
                        return
                end
                local rc = config.exitcodes and config.exitcodes[exitcode]
                if rc == "die" then
                        return rc
                end
                if agent.isList then
                        if rc == "again" then
                                log("Normal", "Retrying events list on exitcode = ", exitcode)
                        else
                                log("Normal", "Finished events list = ", exitcode)
                        end
                else
                        if rc == "again" then
                                log("Normal", "Retrying ", agent.etype, " on ", agent.sourcePath, " = ", exitcode)
                        else
                                log("Normal", "Finished ", agent.etype, " on ", agent.sourcePath, " = ", exitcode)
                        end
                end
                return rc
        end,
        init = function(event)
                local inlet = event.inlet;
                local config = inlet.getConfig();
                log("Normal", "Recursive startup sync: ", config.syncid, ":", config.source)
                spawn(event, "$CSYNC_BIN", "-C", config.syncid, "-x")
        end,
        prepare = function(config)
                if not config.syncid then
                        error("Missing 'syncid' parameter.", 4)
                end
                local c = "csync2_" .. config.syncid .. ".cfg"
                local f, err = io.open("$CSYNC_CONFIG_DIR/" .. c, "r")
                if not f then
                        error("Invalid 'syncid' parameter: " .. err, 4)
                end
                f:close()
        end
}
local sources = {
        -- ["/host/srv/data"] = "default"
}
for key, value in pairs(sources) do
        sync {initSync, source=key, syncid=value}
end
EOF
fi
if [ ! -e $LSYNC_LOG ]; then
    mkdir -p `dirname $LSYNC_LOG`
fi