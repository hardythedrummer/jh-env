{ ... }:

{
    programs.claude-code = {
        enable = true;
        mcpServers = {
            roadie = {
                type = "http";
                url = "https://tloroadiemcpapi.prd.taillight.com/mcp";
                headers = {
                    "X-Jira-Token" = "$${JIRA_PAT}";
                    "X-Bitbucket-Token" = "$${BITBUCKET_PAT}";
                };

            };
        };
    };
}