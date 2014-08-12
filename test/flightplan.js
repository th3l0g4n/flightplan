var Flightplan = require('../index');

var SSH_HOST = 'localhost'
  , SSH_USER = process.env.SSH_USER
  , SSH_AUTH_SOCK = process.env.SSH_AUTH_SOCK
  , SUDO_USER = process.env.SUDO_USER;

var plan = new Flightplan();

plan.briefing({
  destinations: {
    test_single: {
      host: SSH_HOST,
      username: SSH_USER,
      agent: SSH_AUTH_SOCK
    }
  }
});

plan.local(function(local) {
  local.echo('test');
});

plan.remote(function(remote) {
  remote.echo('test');
  remote.sudo('pwd', { user: SUDO_USER });
  remote.sudo('echo test', { user: SUDO_USER });
});