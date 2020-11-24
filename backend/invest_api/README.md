# Invest Api

## Infrastructure Construct by IaC

### Create aws EC2 server

```bash
mix pulumi up --yes
```

### Config aws EC2 server

```bash
mix ansible
```

## Deploy App

### Config SSH Alias for elixir deliver

```bash
vim ~/.ssh/config.d/invest
```

```text
Host invest
    HostName replace-your-ec2-public-dns.compute-1.amazonaws.com
    User ubuntu
    IdentityFile ~/.ssh/private_invest_key
```

### Build release

```bash
mix edeliver build release
```

### Deploy release

Using the version number from the build release command, run the deploy to production command:

```bash
mix edeliver deploy release to production --version=0.1.0+1-26b6853
```

### Restart prod server

```bash
mix edeliver restart production
```

## Ref

[Automate Your Elixir Deployments - Part 1 - Ansible](https://hashrocket.com/blog/posts/automate-your-elixir-deployments-part-1-ansible#setting-up-nginx)

[Automate Your Elixir Deployments - Part 2 - Distillery & eDeliver](https://hashrocket.com/blog/posts/automate-your-elixir-deployments-part-2-distillery-edeliver#assumptions)