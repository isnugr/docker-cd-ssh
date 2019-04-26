# Docker Image for Continuous Deployment over SSH, by [FEROX](https://ferox.yt)

![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/frxyt/cd-ssh.svg)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/frxyt/cd-ssh.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/frxyt/cd-ssh.svg)
![GitHub issues](https://img.shields.io/github/issues/frxyt/docker-cd-ssh.svg)
![GitHub last commit](https://img.shields.io/github/last-commit/frxyt/docker-cd-ssh.svg)

* Docker Hub: https://hub.docker.com/r/frxyt/cd-ssh
* GitHub: https://github.com/frxyt/docker-cd-ssh

## Docker Hub Image

**`frxyt/cd-ssh`**

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
    - cd /path/to/app && git fetch
    - cd /path/to/app && git checkout ${CI_COMMIT_SHA}

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