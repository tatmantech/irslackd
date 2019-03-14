# irslackd

[Slack ended IRC support][0] on May 15, 2018. So, [they][6] built their own Slack-IRC
gateway.

irslackd is actively developed and used daily on a 1000+ user Slack workspace.

[![Build Status](https://travis-ci.org/adsr/irslackd.svg?branch=master)](https://travis-ci.org/adsr/irslackd)

### Features

* TLS-encrypted IRCd
* Multiple Slack accounts/workspaces
* Channels, private channels, DMs, group DMs, threads
* Receive reactions, message edits, message deletes, attachments
* Proper en/decoding of @user, #channel, @team tags
* Dockerfile install for easier isolation 

### Setup

1. [Install Node >=8.x][1] and npm. You can check your version of Node by
   running `node --version`.

2. Clone irslackd:
    ```
    $ git clone https://github.com/adsr/irslackd.git
    $ cd irslackd
    $ npm install    # Fetch dependencies into local `node_modules/` directory 
                     # packages.json was updated with current eslint as npm install was
                     # failing without specifying production
    ```

3. Run `./bin/create_tls_key.sh` to create a TLS key and cert. This will put
   a private key and cert in `./.irslackd`. Note the fingerprint.
   This is an automated install for Docker only. The `./bin/create_tls_key.sh` file has
   been altered to include default params for the keygen. Check it for details. Also, note
   default program inserts key/cert in home directory `${HOME}/.irslackd`, this has been 
   altered accordingly as well.

4. Run irslackd:
    ```
    $ ./irslackd
    ```

    By default irslackd listens on `127.0.0.1:6697`. This version has been changed
    to listen global on `0.0.0.0:6697` so docker expose will work. Set the command line
    options `-p <port>` and/or `-a <address>` to change the listen address. Also, parameters
    are hardcoded in irslackd file.

5. Follow the link below to obtain an irslackd token for your Slack workspace:

   [![Authorize irslackd](https://platform.slack-edge.com/img/add_to_slack.png)][2]

   Select the desired workspace in the dropdown in the upper right corner. Click
   'Authorize', and copy the access token. It will look something like this:

   `xoxp-012345678901-012345678901-012345678901-0123456789abcdef0123456789abcdef`

6. Connect to irslackd via your IRC client, e.g., WeeChat:
    ```
    /server add irslackd_workspace localhost/6697
    /set irc.server.irslackd_workspace.ssl on
    /set irc.server.irslackd_workspace.ssl_fingerprint fingerprint-from-step-3
    /set irc.server.irslackd_workspace.password access-token-from-step-5
    /connect irslackd_workspace
    ```
    Check the wiki for more [client configuration notes][5].

7. Repeat steps 5 and 6 for each Slack workspace you'd like to connect to.

8. Enjoy a fresh IRC gateway experience.

### Contribute

* Add more [client configuration notes][5].
* File bug reports and feature requests via [Github issues][3].
* Feel free to submit PRs. Make sure to include tests.

### Tests

* To run all tests: `npm test`
* To run a single test, e.g.: `npm test test_join`

### Related projects

* https://github.com/ltworf/localslackirc (another gateway, Python)
* https://github.com/insomniacslk/irc-slack (another gateway, Go)
* https://github.com/wee-slack/wee-slack (a terminal client, WeeChat-based)
* https://github.com/erroneousboat/slack-term (a terminal client, Go)
* https://github.com/42wim/matterircd (an IRCd for Mattermost and Slack)
* https://github.com/dylex/slack-libpurple (Slack plugin for libpurple)

### irslackd Slack workspace

* Feel free to join the [irslackd Slack workspace][4] for testing your
  irslackd setup.

[0]: https://my.slack.com/account/gateways
[1]: https://nodejs.org/
[2]: https://slack.com/oauth/authorize?client_id=2151705565.329118621748&scope=client
[3]: https://github.com/adsr/irslackd/issues
[4]: https://join.slack.com/t/irslackd/shared_invite/enQtNDUzMTgzNzAyNDUxLWVhMzgwMTYyYzczN2Y0ZmIyYmEyZDgwZDk2MTdiZmVjZTJhM2FkMjgzOTEyMmNiNGY2YzU2MzgxZGExYWY3ZDA
[5]: https://github.com/adsr/irslackd/wiki/IRC-Client-Config
[6]: https://github.com/adsr/irslackd
