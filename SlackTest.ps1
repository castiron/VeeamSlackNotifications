####################
# Import Functions #
####################
Import-Module "$PSScriptRoot\Helpers"

# Get the config from our config file
$config = (Get-Content "$PSScriptRoot\config\vsn.json") -Join "`n" | ConvertFrom-Json

# Should we log?
if($config.debug_log) {
	Start-Logging "$PSScriptRoot\log\debug.log"
}

# Build the payload
$slackJSON = @{}
$slackJSON.channel = $config.channel
$slackJSON.username = $config.service_name
$slackJSON.icon_url = $config.icon_url
$slackJSON.text = ':exclamation: Veeam notification test  :exclamation:'

# Build the web request
$webReq=@{
    Uri = $config.webhook
    ContentType = 'application/json'
    Method = 'Post'
    body = ConvertTo-Json $slackJSON
}

# Send it to Slack
$request = Invoke-WebRequest -UseBasicParsing @webReq
