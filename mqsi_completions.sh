#/usr/bin/env bash
_mqsilist_completions_running_eg()
{
    local prev="${COMP_WORDS[COMP_CWORD -1]}"
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local IFS=$'\n'
    COMPREPLY=()
    if [[ "${#COMP_WORDS[@]}" = "2" ]]; then
        COMPREPLY=($(compgen -W "$(ls -1 $MQSI_WORKPATH/components)" -- "${COMP_WORDS[1]}"))
        return
    elif [[ "$prev" = '-e'  ]]; then
        local broker="${COMP_WORDS[1]}"
        egs=$(ps -ef | grep DataFlowEngin | grep ${broker} | grep -v grep | grep -o '[^ ]*$')
        COMPREPLY=($(compgen -W "$egs" -- "$cur"))
        return
    elif [[ "$prev" = '-o'  ]]; then
        local objects='ExecutionGroup
AllMessageFlows
AllSubFlows
AllSubFlowUse
SharedLibraryDependencies
SharedLibraryDependents
AllApplications
AllLibraries
Administration
Aggregation
CallableFlowManager
ComIbmActivityLogManager
ComIbmAdapterResourceManager
ComIbmAdminApiManager
ComIbmAggregateNodeFactory
ComIbmAppDomainResourceManager
ComIbmBasicNodeFactory
ComIbmCICSStatsManager
ComIbmCORBAStatsManager
ComIbmCacheManager
ComIbmCallableFlowNodeFactory
ComIbmConfigurationNodeFactory
ComIbmConnectDirectStatsManager
ComIbmCpiParserFactory
ComIbmDFDLParserFactory
ComIbmDataCaptureManager
ComIbmDatabaseConnectionManager
ComIbmDecisionServicesStatsManager
ComIbmDummyParserFactory
ComIbmESQLResourceManager
ComIbmFTEAgentStatsManager
ComIbmFTPStatsManager
ComIbmFileStatsManager
ComIbmGeneralParserFactory
ComIbmGenericParserFactory
ComIbmGenericXmlParserFactory
ComIbmGlobalCacheStatsManager
ComIbmGroupNodeFactory
ComIbmHTTPAsyncSocketManager
ComIbmIDLResourceManager
ComIbmIDOCParserFactory
ComIbmIIBSwitchManager
ComIbmInternalSupportManager
ComIbmJDBCConnectionPoolsStatsManager
ComIbmJMSStatsManager
ComIbmJSONParserFactory
ComIbmJSONResourceManager
ComIbmJSONStatsWriter
ComIbmJVMManager
ComIbmJavaNodeFactory
ComIbmJavaPluginNodeFactory
ComIbmJmsTransformNodeFactory
ComIbmMAPResourceManager
ComIbmMQConnectionManager
ComIbmMQNodeFactory
ComIbmMQParserFactory
ComIbmMtiParserFactory
ComIbmNodejsManager
ComIbmODBCStatsManager
ComIbmPEPNodeFactory
ComIbmPHPResourceManager
ComIbmParserManager
ComIbmResourceStatsManager
ComIbmRuleResourceManager
ComIbmSAPStatsManager
ComIbmSCANodeFactory
ComIbmSOAPAsyncNodeManager
ComIbmSOAPHandleManager
ComIbmSOAPPipelineManager
ComIbmSOAPStatsManager
ComIbmSQLNodeFactory
ComIbmSchemaResourceManager
ComIbmSecurityDirector
ComIbmServiceDirectory
ComIbmSiebelManager
ComIbmSocketConnectionManager
ComIbmStatsCollector
ComIbmStatsFileWriter
ComIbmStatsLogmetWriter
ComIbmTCPIPClientNodesStatsManager
ComIbmTCPIPServerNodesStatsManager
ComIbmTimeoutNodeFactory
ComIbmUserTraceStatsWriter
ComIbmWSDLResourceManager
ComIbmWSNodeFactory
ComIbmWSParserFactory
ComIbmWTXManager
ComIbmXAStatsManager
ComIbmXMLResourceManager
ComIbmXMLStatsWriter
ComIbmXPathCache
ComIbmXSDResourceManager
ComIbmXSLResourceManager
ComIbmXmlParserFactory
ComIbmYAMLResourceManager
ConfigurationManager
ConnectorNodeFactory
Connectors
ContentBasedFiltering
EventLog
ExceptionLog
FTEAgent
FlowThreadReporter
GroupDirector
HTTPConnector
HTTPSConnector
ImbDFDLSchemaManager
ImbESQLManager
ImbXMLNSCSchemaManager
JAR
Kafka
MIMEFactory
MQ
MQTT
REST
ServiceFederationManager
TCPIP
TraceLog
TransactionDirector
UserTraceLog
WLM
iib-loopback-connector
iib-salesforce-connector'
        
        COMPREPLY=($(compgen -W "$objects" -- "$cur"))
        return
    else
        _filedir;
        return;
    fi
}

_mqsilist_completions()
{
    local prev="${COMP_WORDS[COMP_CWORD -1]}"
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local IFS=$'\n'
    COMPREPLY=()
    if [[ "${#COMP_WORDS[@]}" = "2" ]]; then
        COMPREPLY=($(compgen -W "$(ls -1 $MQSI_WORKPATH/components)" -- "${COMP_WORDS[1]}"))
        return
    elif [[ "$prev" = '-e'  ]]; then
        local broker="${COMP_WORDS[1]}"
        egs=""
        if [[ $MQSI_VERSION_V -lt 11 ]]; then
            for l in $(echo 'cat /table/row/@ExecGroupLabel' | xmllint --shell $MQSI_WORKPATH/components/${broker}/repository/brokeraaeg.dat | awk -F\" 'NR % 2 == 0 { print $2; }' ) ; do
                egs=$(echo $l | base64 -d)$'\n'${egs};
            done
        else
            egs=$(ls -1 $MQSI_WORKPATH/components/${broker}/servers)
        fi
        COMPREPLY=($(compgen -W "$egs" -- "$cur"))
        return
    else
        _filedir;
        return;
    fi
}


complete -o nospace -F _mqsilist_completions mqsilist
complete -o nospace -F _mqsilist_completions_running_eg mqsistop
complete -o nospace -F _mqsilist_completions_running_eg mqsideploy
complete -o nospace -F _mqsilist_completions mqsistart
complete -o nospace -F _mqsilist_completions_running_eg mqsireload
complete -o nospace -F _mqsilist_completions_running_eg mqsistopmsgflow
complete -o nospace -F _mqsilist_completions mqsistartmsgflow
complete -o default -o nospace -F _mqsilist_completions_running_eg mqsireportproperties
complete -o default -o nospace -F _mqsilist_completions_running_eg mqsichangeproperties
complete -o nospace -F _mqsilist_completions mqsicreateexecutiongroup
complete -o nospace -F _mqsilist_completions mqsideleteexecutiongroup
complete -o nospace -F _mqsilist_completions_running_eg mqsireportflowmonitoring

