const { app } = require('@azure/functions');
const { WebClient, retryPolicies } = require('@slack/web-api');

const token = process.env.SLACK_BOT_TOKEN;
const slackMessage = process.env.SLACK_MESSAGE || `This is a test!`;

retryConfig = {
  retries: 0
};

const web = new WebClient(token, {
  retryConfig: retryConfig,
});

app.http('HttpSlackFunction', {
    methods: ['GET', 'POST'],
    authLevel: 'anonymous',
    handler: async (request, context) => {
        context.log(`Http function processed request for url "${request.url}"`);

        // Send message
        context.log("Sending slack message");
        await web.chat.postMessage({
          text: slackMessage,
          channel: process.env.SLACK_CHANNEL_ID
        }).then(response => {
          context.log(`Slack notification sent`);
        }).catch(error => {
          context.log(`Error sending slack notification: ${error}`);
          return { body: `Error sending slack message!` };
        });

        return { body: `Slack mesage sent!` };
    }
});
