gitlab-ci-setup
======================

> Introduced Gitlab CI : [Gitlab Runner](https://docs.gitlab.com/runner/)

---

## Description

GitLab Runner is the open source project that is used to run your jobs and send the results back to GitLab. <br>
It is used in conjunction with GitLab CI, the open-source continuous integration service included with GitLab that coordinates the jobs. <br>

---

## Version

`Rev: 1.0.1`

---

## Purpose
To integrate our gitlab server as CI/CD automation system.

---

## Usage

  
  - Execute the shell script for setup gitlab-ci-runner.

    
    ```bash
    $ bash setup_ci.sh
    ```
  
  - Input regarding the gitlab-ci arguments.

    
    ```bash
    Please Input Runner token =>: ${share_token}
    Please Input Gitlab URL   =>: ${gitlab_url}
    Please Input Gitlab IP   =>: ${gitlab_ip}
    Please define the git-ci tag =>: ${git_tag}
    ```

---

## Associates

  - **Developer**
    - Chang.Jay

---

## Contact
##### Author: Jay.Chang
##### Email: cqe5914678@gmail.com





