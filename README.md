# Docker Image for Continuous Deployment over SSH, by [FEROX](https://ferox.yt)

![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/frxyt/cd-ssh.svg)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/frxyt/cd-ssh.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/frxyt/cd-ssh.svg)
![GitHub issues](https://img.shields.io/github/issues/frxyt/docker-cd-ssh.svg)
![GitHub last commit](https://img.shields.io/github/last-commit/frxyt/docker-cd-ssh.svg)

Use this image to increase your development speed. No need to create your own `Dockerfile`,
or `gitlab-ci.yml` with a lot of ssh-related things, just ask this image to do the job for you !

This image will lookup for environment variables set by your CI/CD to deploy anything via SSH.

* Docker Hub: https://hub.docker.com/r/frxyt/cd-ssh
* GitHub: https://github.com/frxyt/docker-cd-ssh

## Docker Hub Image

**`frxyt/cd-ssh`**

## Variables

### Configurable environment variables

These environment variables can be overriden to change the default behavior of the image and adapt it to your needs:

| Name              | Type      | Example                               | Description
| :---------------- | :-------- | :------------------------------------ | :----------
| `FRX_VARS_DEBUG`  | `string`  | ` ` *(Empty, Off)* / `true` *(On)     | Display or not readed variables, disabled by default.
| `FRX_VARS_PREFIX` | `string`  | `APP_TEST_`                           | Set a prefix for `SSH_*` variables, empty by default.
| `SSH_PRIVATE_KEY` | `string`  | `-----BEGIN RSA PRIVATE KEY-----...`  | Set the private key to use, empty by default.
| `SSH_KNOWN_HOSTS` | `string`  | *Content of `ssh-keyscan <hostname>`* | Set the `known_hosts` file content, empty by default.
| `SSH_USER`        | `string`  | `user`                                | Set the username to use, empty by default.
| `SSH_PASS`        | `string`  | `P@sSw0rd`                            | Set the password to use, empty by default.
| `SSH_HOST`        | `string`  | `example.com`                         | Set the hostname to use, empty by default.
| `SSH_PORT`        | `string`  | `22`, `2222`                          | Set the port number to use, empty by default.

Notes:

* When `FRX_VARS_DEBUG` is not empty, the retrieved variables values will be displayed.
* When `FRX_VARS_PREFIX` has a value, all variables beginning with `SSH_` can be prefixed by the content of `FRX_VARS_PREFIX`.
  * The prefixed value will be used if found, otherwise the non-prefixed variable will be used.
  * For example, if `FRX_VARS_PREFIX` is set to `APP_TEST_`: 
    so, if both variables `APP_TEST_SSH_HOST` and `SSH_HOST` are set, the image will use the value of `APP_TEST_SSH_HOST`.
* When `SSH_PRIVATE_KEY` is empty, the image will use a password authentification with `sshpass`.
* When `SSH_KNOWN_HOSTS` is empty, the image will retrieve automatically the host signature with `ssh-keyscan`.
* When `SSH_PORT` is empty, the default SSH port will be used (`22`).

## `gitlab-ci.yml` example

```yaml
stages:
  - deploy

.template:deploy: &template_deploy
  image: frxyt/cd-ssh
  tags:
    - docker-all
  stage: deploy
  script:
    - cd-ssh "cd /path/to/app && git fetch"
    - cd-ssh "cd /path/to/app && git checkout ${CI_COMMIT_SHA}"

deploy:test:
  <<: *template_deploy
  environment:
    name: test
    url: https://app.example.com
  only:
    - develop
  variables:
    FRX_VARS_PREFIX: APP_TEST_
```

Then, these variables must be defined in `Settings > CI / CD > Environment variables`:

* `APP_TEST_SSH_HOST`
* `SSH_KNOWN_HOSTS`
* `SSH_PRIVATE_KEY`
* `SSH_USER`

## License

This project and images are published under the [MIT License](LICENSE).

```
MIT License

Copyright (c) 2019 FEROX YT EIRL, www.ferox.yt <devops@ferox.yt>
Copyright (c) 2019 Jérémy WALTHER <jeremy.walther@golflima.net>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```