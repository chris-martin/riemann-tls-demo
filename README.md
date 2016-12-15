This repo demonstrates generating client and server certs with [easy-rsa] and
using them to securely forward events between two [Riemann] servers via TLS.

  [easy-rsa]: https://github.com/OpenVPN/easy-rsa
  [Riemann]: http://riemann.io/

Run `./setup.sh` and follow the prompts to generate a CA, private keys, and
certificates.

Then start the three Riemann instances:

```bash
riemann riemann-alice.config
riemann riemann-bob.config
riemann riemann-eve.config
```

When we send an event to Alice,

```bash
riemann-cli send --tcp --port 5001 --service "foo" --metric 50 --state ok
```

Alice forwards it to Bob, and we can see it in both of their logs.

When we send an event to Eve,

```bash
riemann-cli send --tcp --port 5002 --service "foo" --metric 50 --state ok
```

it prints in Eve's log, but in Bob's log we just see an SSL handshake error
because Eve does not have a client certificate.
