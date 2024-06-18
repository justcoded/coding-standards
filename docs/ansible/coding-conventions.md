# Justcoded Ansible Coding Style and Conventions 

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL"
in this document are to be interpreted as described in [RFC 2119](https://datatracker.ietf.org/doc/html/rfc2119).

<!-- TOC -->
* [Justcoded Ansible Coding Style and Conventions](#justcoded-ansible-coding-style-and-conventions-)
* [Coding style](#coding-style)
  * [Playbook File Extension](#playbook-file-extension)
  * [The beginning of a file](#the-beginning-of-a-file)
  * [The end of the file](#the-end-of-the-file)
  * [Spaces and alignment](#spaces-and-alignment)
    * [Key/value pairs](#keyvalue-pairs)
    * [Whitespace and Comments](#whitespace-and-comments)
    * [Air and tabulators](#air-and-tabulators)
  * [Order in playbook](#order-in-playbook)
  * [Order in task declaration](#order-in-task-declaration)
  * [Task names](#task-names)
    * [Names](#names)
    * [Always name tasks](#always-name-tasks)
    * [Format for task names](#format-for-task-names)
    * [Variables in Task Names](#variables-in-task-names)
    * [Omitting Unnecessary Information](#omitting-unnecessary-information)
  * [Variable names](#variable-names)
    * [Always use `snake_case` for variable names.](#always-use-snakecase-for-variable-names)
    * [The prefix should contain the name of the role.](#the-prefix-should-contain-the-name-of-the-role)
    * [Variable precedence](#variable-precedence)
    * [Define temporary variables using unique prefix](#define-temporary-variables-using-unique-prefix)
    * [Define paths without trailing slash](#define-paths-without-trailing-slash)
  * [Boolean variables](#boolean-variables)
    * [Comparing](#comparing)
  * [Use Modules instead of command or shell](#use-modules-instead-of-command-or-shell)
  * [Always Mention The State](#always-mention-the-state)
  * [Use Block-Module](#use-block-module)
  * [Use lists](#use-lists)
* [Coding conventions](#coding-conventions)
  * [Vaults](#vaults)
  * [Content Organization](#content-organization)
    * [Directory Layout](#directory-layout)
    * [Group And Host Variables](#group-and-host-variables)
    * [Top Level Playbooks Are Separated By Role](#top-level-playbooks-are-separated-by-role)
    * [Bundling Ansible Modules With Playbooks](#bundling-ansible-modules-with-playbooks)
  * [Playbooks optimization](#playbooks-optimization)
    * [Import vs Include](#import-vs-include)
      * [Tradeoffs and Pitfalls Between Includes and Imports](#tradeoffs-and-pitfalls-between-includes-and-imports)
    * [Optimize Playbook Execution](#optimize-playbook-execution)
    * [Use Module synchronize Instead of copy for Large Files](#use-module-synchronize-instead-of-copy-for-large-files)
  * [Configuration conventions](#configuration-conventions)
    * [Optimize SSH Connections](#optimize-ssh-connections)
    * [Enabling Pipelining](#enabling-pipelining)
<!-- TOC -->

# Coding style

The main reason for this style guide is to have one consistent way of writing Ansible which is easy to read for you and others.

First of all, follow [Sample Ansible setup](https://docs.ansible.com/ansible/latest/tips_tricks/sample_setup.html) and use Ansible Lint ...

Use IDE plugins for autocomplete and validation, the best one is OrchidE (https://www.orchide.dev/)


## Playbook File Extension

All Ansible Yaml files should have a **.yml** extension (and NOT **.YML**, **.yaml** etc).

## The beginning of a file

Always start your file with the YAML heading which is `---`.

Please add comments above these lines with descriptions of what this playbook is and an example of how to run it.

✅ ***Good***
```yaml
# This playbook playbook changes state of user foo
# Example: ansible-playbook -e state=stopped playbook.yml
---
- name: Change status of user foo
  ansible.builtin.service:
    enabled: true
    name: foo
    state: '{{ state }}'
  become: true
```
❌ ***Bad***
```yaml
- name: Change status of user foo
  ansible.builtin.service:
    enabled: true
    name: foo
    state: '{{ state }}'
  become: true
```

>**🔎 Why do this?**
>
>This makes it quick to find out what the playbook does.
Either with opening the file or just using the `head` command.

## The end of the file

Always end the file with a line shift.

>**🔎 Why do this?**
>
>It's just Unix best practices.
>It avoids messing up your prompt when you `cat` a file.

## Spaces and alignment

### Key/value pairs

Only use on space after colon when you define key value pair.

✅ ***Good***

```yaml
---
- name: start chrony NTP daemon
  ansible.builtin.service:
    name: chrony
    state: started
    enabled: true
  become: true
```

❌ ***Bad***

```yaml
---
- name: start chrony NTP daemon
  ansible.builtin.service:
    name    : chrony
    state   : started
    enabled : true
  become : true
```

Keep to only one standard. In our case **always use the "map" syntax**.
This is regardless of how many key/value pairs that exist in a map.

✅ ***Good***

```yaml
---
- name: disable ntpd
  ansible.builtin.service:
    name: '{{ ntp_service }}'
    state: stopped
    enabled: false
  become: true

```

❌ ***Bad***

```yaml
---
- name: disable ntpd
  ansible.builtin.service: name='{{ ntp_service }}' state=stopped enabled=false
  become: true
```
>**🔎 Why do this?**
>
>It's **soooo** much easier to read, and not more work to do.
>As the writer of this document is dyslectic, think of him and others in the same situation In addition to the readability, it decreases the chance for a merge conflict.


### Whitespace and Comments

Generous use of whitespace to break things up, and use of comments (which start with ‘#’), is encouraged.

### Air and tabulators

:memo: Tabulator stops must be set to two, `2`, spaces.

:memo: Air, one of the **most important thing** for humans and **for code**! 

It must be an empty line:
* before `vars`, `pre_tasks`, `roles` and `tasks`,
* before each task in the tasks definition.


✅ ***Good***

```yaml
---
- name: Install and Launch the Simple NodeJS Application
  hosts: testserver

  vars_files:
    - gitsecrets.yml

  vars:
    - destdir: /apps/sampleapp

  pre_tasks:
    - name : install dependencies before starting
      become: yes
      register: aptinstall
      apt:
        name:
          - nodejs
          - npm
          - git
        state: latest
        update_cache: yes

    - name : validate the nodejs installation
      debug: msg="Installation of node is Successfull"
      when: aptinstall is changed

  tasks:
    - name: Version of Node and NPM
      shell:
        "npm -v && nodejs -v"
      register: versioninfo
    - name: Validate if the installation is intact
      assert:
        that: "versioninfo is changed"

    - name: Create Dest Directory if not exists
      become: yes
      file:
        path: "{{ destdir }}"
        state: directory
        owner: vagrant
        group: vagrant
        mode: 0755
        
    - name: Download the NodeJS code from the GitRepo
      become: yes
      git:
        repo: 'https://{{gittoken}}@github.com/AKSarav/SampleNodeApp.git'
        dest: "{{ destdir }}"
        
    - name: Change the ownership of the directory
      become: yes
      file:
        path: "{{destdir}}"
        owner: "vagrant"
      register: chgrpout
      
    - name: Install Dependencies with NPM install command
      shell:
        "npm install"
      args:
        chdir: "{{ destdir }}"
      register: npminstlout
    - name: Debug npm install command
      debug: msg='{{npminstlout.stdout_lines}}'
    - name: Start the App
      async: 10
      poll: 0
      shell:
        "(node index.js > nodesrv.log 2>&1 &)"
      args:
        chdir: "{{ destdir }}"
      register: appstart

    - name: Validating the port is open
      tags: nodevalidate
      wait_for:
        host: "localhost"
        port: 5000
        delay: 10
        timeout: 30
        state: started
        msg: "NodeJS server is not running"
        
  post_tasks:
    - name: notify Slack that the servers have been updated
      tags: slack
      community.general.slack:
        token: T026******PF/B02U*****N/WOa7r**********Ao0jnWn
        msg: |
          ### StatusUpdate ###
          – ------------------------------------
          ``
          `Server`: {{ansible_host}}
          `Status`: NodeJS Sample Application installed successfully
          – ------------------------------------
        channel: '#ansible'
        color: good
        username: 'Ansible on {{ inventory_hostname }}'
        link_names: 0
        parse: 'none'
      delegate_to: localhost
```

❌ ***Bad***

```yaml
---
- name: Install and Launch the Simple NodeJS Application
  hosts: testserver
  vars_files:
     - gitsecrets.yml
  vars:
     - destdir: /apps/sampleapp
  pre_tasks:
     - name : install dependencies before starting
        become: yes
        register: aptinstall
        apt:
          name:
             - nodejs
             - npm
             - git
          state: latest
          update_cache: yes
     - name : validate the nodejs installation
        debug: msg="Installation of node is Successfull"
        when: aptinstall is changed
  tasks:
     - name: Version of Node and NPM
        shell:
          "npm -v && nodejs -v"
        register: versioninfo
     - name: Validate if the installation is intact
        assert:
          that: "versioninfo is changed"
     - name: Create Dest Directory if not exists
        become: yes
        file:
          path: "{{ destdir }}"
          state: directory
          owner: vagrant
          group: vagrant
          mode: 0755
     - name: Download the NodeJS code from the GitRepo
        become: yes
        git:
          repo: 'https://{{gittoken}}@github.com/AKSarav/SampleNodeApp.git'
          dest: "{{ destdir }}"
     - name: Change the ownership of the directory
        become: yes
        file:
          path: "{{destdir}}"
          owner: "vagrant"
        register: chgrpout
     - name: Install Dependencies with NPM install command
        shell:
          "npm install"
        args:
          chdir: "{{ destdir }}"
        register: npminstlout
     - name: Debug npm install command
        debug: msg='{{npminstlout.stdout_lines}}'
     - name: Start the App
        async: 10
        poll: 0
        shell:
          "(node index.js > nodesrv.log 2>&1 &)"
        args:
          chdir: "{{ destdir }}"
        register: appstart
     - name: Validating the port is open
        tags: nodevalidate
        wait_for:
          host: "localhost"
          port: 5000
          delay: 10
          timeout: 30
          state: started
          msg: "NodeJS server is not running"
  post_tasks:
     - name: notify Slack that the servers have been updated
        tags: slack
        community.general.slack:
          token: T026******PF/B02U*****N/WOa7r**********Ao0jnWn
          msg: |
             ### StatusUpdate ###
             – ------------------------------------
             ``
             `Server`: {{ansible_host}}
             `Status`: NodeJS Sample Application installed successfully
             – ------------------------------------
          channel: '#ansible'
          color: good
          username: 'Ansible on {{ inventory_hostname }}'
          link_names: 0
          parse: 'none'
        delegate_to: localhost
```

>**🔎 Why do this?**
>
>This creates a pretty and tidy code which is easy to read, both for dyslectic and non dyslectic people. There is no excuse not to do this.



## Order in playbook

Playbook definitions should follow this order.

* `name`
* `hosts`
* `remote_user`
* `become`
* `vars`
* `pre_tasks`
* `roles`
* `tasks`

✅ ***Good***
```yaml
---
- name: update root authorized_keys for all machines
  hosts:
    - all
  become: true

  vars:
    root_keys_users:
      - user: user1
        key: |
          ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHkCVF05JvfkrfOOESivOxV4N8+A/EMEkF7/nCQMRoQg
        enabled: true

  pre_tasks:
    - name: add custom root users
      set_fact:
        root_keys_users: "{{ root_keys_users | union( root_keys_users_custom|default([]) ) }}"

  roles:
    - role: root-keys

  tasks:
    - name: print out debug message
      ansible.builtin.debug:
        msg: "fee foo faa"
```

>**🔎 Why do this?**
>
>A common order makes playbooks consistent and easier to read for your dear colleagues. Think of them when you write.

## Order in task declaration

A task should be declared in this order.

* `name`
* module and the arguments for the module
* arguments for the task in correct order
* `tags` at the bottom

✅ ***Good***
```yaml
---
- name: unhold packages
  ansible.builtin.shell: 'apt-mark -s unhold {{ item }} && apt-mark unhold {{ item }}'
  args:
    #chdir:      # change dir before execution
    #cmd:        # The command to run followed by optional arguments.
    #creates:    # A filename, when it already exists, this step will not be run.
    executable: /bin/bash
    #free_form:  # The shell module takes a free form command to run, as a string.
                 # There is no actual parameter named ‘free form’.
                 # See the documentation on how to use.
    #removes:    # A filename, when it does not exist, this step will not be run.
    #stdin:      # Set the stdin of the command directly to the specified value.
    #stdin_add_newline: 
                # Whether to append a newline to stdin data. (true / false)
  changed_when: apt_mark_unhold.rc == 0 and "already" not in apt_mark_unhold.stdout
  failed_when: false
  loop: '{{ packages_ubuntu_unhold }}'
  register: apt_mark_unhold
  tags:
    - apt_unhold
---
```

## Task names

### Names

All the newly created Ansible roles should follow the name convention using dashes if necessary:
`<vendor>-<action>-[function/technology]`

✅ ***Good***

```yaml
jc-setup-lvm
```

❌ ***Bad***
```yaml
lvm
```

### Always name tasks

It is possible to leave off the ‘name’ for a given task, though it is recommended to provide a description about why something is being done instead.
This name is shown when the playbook is run.

### Format for task names

Always use the following format in task names:

 `<task file name without extension> | <description>`

✅ ***Good***

```yaml
- name: 'SwitchHttpdStatus | Change status of httpd to {{ state }}'
```

❌ ***Bad***

```yaml
- name: 'Change status of httpd to {{ state }}'
```

>**🔎 Why do this?**
>
>It will always be clear what task was performed when analyzing the log.

### Variables in Task Names

Include as much information as necessary to explain the purpose of a task.
Make usage of variables inside a task name to create dynamic output messages.

✅ ***Good***

```yaml
- name: 'Change status of httpd to {{ state }}'
  service:
  enabled: true
  name: 'httpd'
  state: '{{ state }}'
  become: true
```

❌ ***Bad***

```yaml
- name: 'Change status'
  service:
  enabled: true
  name: 'httpd'
  state: '{{ state }}'
  become: true
```
>**🔎 Why do this?**
>
>This will help to easily understand log outputs of playbooks.

### Omitting Unnecessary Information
While name tasks in a playbook, do not include the name of the role which is currently executed, since Ansible will do this automatically.

>**🔎 Why do this?**
>
>Avoiding the same output twice on the console will prevent confusions.

## Variable names

### Always use `snake_case` for variable names.

✅ ***Good***

```yaml
---
- name: set my variables
  ansible.builtin.set_fact:
    a_boolean: false
    an_int: 101
    a_string: bar
```
❌ ***Bad***

```yaml
---
- name: set my variables
  ansible.builtin.set_fact:
    aBoolean: false
    anint: 101
    A_STRING: bar
```

>**🔎 Why do this?**
>
>Ansible already uses `snake_case` for variables in it's examples. Consistent naming of variables keeps the code tidy and gives better readability.

### The prefix should contain the name of the role.

✅ ***Good***

```yaml
---
- name: 'set some facts'
  set_fact:
    rolename_my_boolean: true
    rolename_my_int: 20
    rolename_my_string: 'test'
```

❌ ***Bad***

```yaml
---
- name: 'set some facts'
  set_fact:
    myBoolean: true
    int: 20
    MY_STRING: 'test'
```

### Variable precedence

Follow this [guide](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_variables.html#understanding-variable-precedence) when defining the variable scope.

You should set defaults in roles to avoid undefined-variable errors.

✅ ***Good***
```yaml
---
# file: roles/x/defaults/main.yml
# if no other value is supplied in inventory or as a parameter, this value will be used
http_port: 80
```

Then override those values at the required level or at the command line.

✅ ***Good***
```yaml
---
# file: roles/x/vars/main.yml
# this will absolutely be used in this role
http_port: 8080
```

### Define temporary variables using unique prefix

Registered variables and facts set using set_fact module are often defined for temporary usage.
In order to avoid variable collision and make it clear to the reader that these variables are only for temporary usage,
it is good practice to use a unique prefix.
You could use r_ for registered variables and f_ for facts.

✅ ***Good***

```yaml
- name: Collect information from external system
  uri:
    url: http://www.example.com
    return_content: yes
  register: r_results
  failed_when: "'AWESOME' not in r_results.content"

- name: Set some facts for temporary usage
  set_fact:
    f_username: "{{ r_results.username }}"
```

### Define paths without trailing slash

Variables that define paths should never have a trailing slash.
Also when concatenating paths, follow the same convention.

✅ ***Good***

```yaml
app_root: /foo
app_bar: "{{ app_root }}/bar"
```

❌ ***Bad***

```yaml
app_root: /foo/
app_bar: "{{ app_root }}bar"
```

## Boolean variables

Always use **false** and **true** values for boolean.

✅ ***Good***
```yaml
---
- name: start chrony NTP daemon
  ansible.builtin.service:
    name: chrony
    state: started
    enabled: true
  become: true
```
❌ ***Bad***

```yaml
---
- name: start chrony NTP daemon
  ansible.builtin.service:
    name: chrony
    state: started
    enabled: 1
  become: yes
```

### Comparing
Do not compare to literal True/False.

✅ ***Good***

```yaml
when: var
```
```yaml
when: not var
```

❌ ***Bad***
```yaml
when: var == True
```
```yaml
when: var == Yes
```
```yaml
when: var != ""
```


## Use Modules instead of command or shell
Before using the `command` or `shell` module, verify if there is already a module available which can avoid the usage of raw shell command.

✅ ***Good***

```yaml
- name: install packages
  tasks:
    - name: 'install httpd'
      yum:
        name: 'httpd'
        state: 'present'
```

❌ ***Bad***
```yaml
- name: install httpd
  tasks:
    - command: "yum install httpd"
```

>**🔎 Why do this?**
>
>While raw command could be seen as a security risk in general, another reason to avoid them is the loss of immutability of the ansible playbooks or roles. Ansible cannot verify if a command has been already executed before or not and will therefore execute it every time the playbook is running.

## Always Mention The State

The ‘state’ parameter is optional to a lot of modules.
Whether ‘state=present’ or ‘state=absent’, it’s always best to leave that parameter in your playbooks to make it clear, especially as some modules support additional states.

✅ ***Good***

```yaml
- name: Example Simple Playbook
  hosts: all
  become: yes

  tasks:
  - name: Copy file example_file to /tmp with permissions
    ansible.builtin.copy:
      src: ./example_file
      dest: /tmp/example_file
      mode: '0644'

  - name: Add the user 'bob' with a specific uid 
    ansible.builtin.user:
      name: bob
      state: present
      uid: 1040

- name: Update postgres servers
  hosts: databases
  become: yes

  tasks:
  - name: Ensure postgres DB is at the latest version
    ansible.builtin.yum:
      name: postgresql
      state: latest

  - name: Ensure that postgresql is started
    ansible.builtin.service:
      name: postgresql
      state: started
```

## Use Block-Module

✅ ***Good***

Block can help to organize the code and can enable rollbacks.
```yaml
- block:
    copy:
      src: critical.conf
      dest: /etc/critical/crit.conf
    service:
      name: critical
      state: restarted
  rescue:
   command: shutdown -h now
```

Also blocks allow for logical grouping of tasks and in play error handling.
Most of what you can apply to a single task (with the exception of loops) can be applied at the block level,
which also makes it much easier to set data or directives common to the tasks. This does not mean the directive affects the block itself,
but is inherited by the tasks enclosed by a block.
i.e. a when will be applied to the tasks, not the block itself.

✅ ***Good***

```yaml
tasks:
   - name: Install, configure, and start Apache
     block:
       - name: install httpd and memcached
         yum:
           name:
           - httpd
           - memcached
           state: present

       - name: apply the foo config template
         template:
           src: templates/src.j2
           dest: /etc/foo.conf
       - name: start service bar and enable it
         service:
           name: bar
           state: started
           enabled: True
     when: ansible_facts['distribution'] == 'CentOS'
     become: true
     become_user: root
     ignore_errors: yes
```
## Use lists
Use lists when ever a modules support it (i.e. yum):


✅ ***Good***
```yaml
tasks:
- name: Ensure the packages are installed
  yum:
  state: present
  name:
  - httpd
  - mod_ssl
  - httpd-tools
  - mariadb-server
  - mariadb
  - php
  - php-mysqlnd
```

***Bad***
```yaml
tasks:
 - name: Ensure the packages are installed
   yum:
     name: "{{ item }}"
     state: present
   loop:
     - httpd
     - mod_ssl
     - httpd-tools
     - mariadb-server
     - mariadb
     - php
     - php-mysqlnd
```
# Coding conventions

## Vaults

All Ansible Vault files should have a **.vault** extension (and NOT **.yml**, **.YML**, **.yaml** etc).

## Content Organization

Always try to use Ansible’s “roles” to organize your playbook content  organization feature.

### Directory Layout

The top level of the directory should contain files and directories like so:
This is the required preset for recognizing playbooks, tasks and variables by [OrchidE plugin](https://www.orchide.dev/pages/dokumentation).  

```text
  project
  |-- inventory
  |   |-- hosts
  |   |-- group_vars
  |   |   |-- webservers
  |   |   |   |-- default.yml
  |-- playbooks
  |   |-- webservers
  |   |   -- main.yml  
  |-- roles
  |   |-- webserver
  |   |   |-- tasks
  |   |   |   |-- main.yml
```

Take care, that file structure for some roles can be completely generated with ansible galaxy.

### Bundling Ansible Modules With Playbooks

If a playbook has a ./library directory relative to its YAML file, this directory can be used to add ansible modules that will automatically be in the ansible module path.
This is a great way to keep modules that go with a playbook together.
This is shown in the directory structure example at the start of this section.

## Playbooks optimization

### Import vs Include

Alway try to break up playbooks into smaller logically separated parts.

Includes and imports allow users to do this, which can be used across multiple parent playbooks or even multiple times within the same Playbook.
A major difference between `import` and `include` tasks:

- `import` tasks will be parsed at the beginning when you run your playbook
(If you use any `import*` Task (`import_playbook`, `import_tasks`, etc.), it will be static.)
- `include` tasks will be parsed at the moment Ansible hits them
(If you use any **include*** Task (**include_tasks**, **include_role**, etc.), it will be dynamic.)

  
**Warning:** The bare `include` task (which was used for both Task files and Playbook-level includes) is still available, however it is now considered deprecated.

#### Tradeoffs and Pitfalls Between Includes and Imports
* Using `include*` vs. `import*` has some advantages as well as some tradeoffs which users should consider when choosing to use each:

* The primary advantage of using `include*` statements is looping. When a loop is used with an include, the included tasks or role will be executed once for each item in the loop.

* Using `include*` does have some limitations when compared to `import*` statements:

* Tags which only exist inside a dynamic include will not show up in `--list-tags` output.

* Tasks which only exist inside a dynamic include will not show up in `--list-tasks` output.

* You cannot use `notify` to trigger a handler name which comes from inside a dynamic include (see note below).

* You cannot use `--start-at-task` to begin execution at a task inside a dynamic include.

* Using `import*` can also have some limitations when compared to dynamic includes:

* As noted above, loops cannot be used with imports at all.

* When using variables for the target file or role name, variables from inventory sources (**host**/**group** vars, etc.) cannot be used.

* Handlers using **import*** will not be triggered when notified by their name, as importing overwrites the handler’s named task with the imported task list.

**Note:** Regarding the use of `notify` for dynamic tasks:
it is still possible to trigger the dynamic include itself, which would result in all tasks within the include being run.

Here is a simple example on the ebove:

✅ ***Good***

```yaml
---
# main.yml

- name: Include tasks
  include_tasks: include_task.yml
  # args:
  #   apply:
  #     tags: task
  tags: task

- name: Import tasks
  import_tasks: import_task.yml
  tags: task

- name: Main task
  debug:
    msg: The main task
  tags: main
```
```yaml
---
#include_task.yml:

- name: Subtask3
  debug:
    msg: Subtask3 include
  tags: task1

- name: Subtask4
  debug:
    msg: Subtask4 include
  tags: task2
```
```yaml
---
#import_task.yml:

- name: Subtask1
  debug:
    msg: Subtask1 import
  tags: task1

- name: Subtask2
  debug:
    msg: Subtask2 import
  tags: task2
```

### Optimize Playbook Execution
Disable facts gathering if it is not required.

Try not to use: ansible_facts[‘hostname’] (or ‘nodename’)

Try to use inventory_hostname and inventory_hostname_short instead

It is possible to selectively gather facts (gather_subnet)

Consider caching facts

Increase Parallelism

Ansible runs 1st task on every host, then 2nd task on every host …

Use “forks” (default is 5) to control how many connections can be active (load will increase, try first with conservative values)

While testing forks analize Enable CPU and Memory Profiling

### Use Module synchronize Instead of copy for Large Files

If you use the module `copy` for large files: do not use `copy` module.
Use “synchronize” module instead (based on rsync)

✅ ***Good***

```yaml
- hosts: test_01

  tasks:
    - name: "copy big file"

    - package:
        name: rsync

    - synchronize:
        src: /tmp/bigfile.tar.gz
        dest: /tmp/test
```

❌ ***Bad***
```yaml
- hosts: test_01

  tasks:
    - name: "copy big file"

    - copy:
        src: /tmp/bigfile.tar.gz
        dest: /tmp/test

```

## Configuration conventions

### Optimize SSH Connections

in `ansible.cfg` set

* ControlMaster
* ControlPersist
* PreferredAuthentications

✅ ***Good***

```text
[ssh_connection]
...
ssh_args=-C -o ControlMaster=auto -o ControlPersist=1200s -o BatchMode=yes -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey
...
```
### Enabling Pipelining

! **Not enabled by default**

reduces number of SSH operations

✅ ***Good***

```text
[ssh_connection]
...
pipelining=true
...
```

**Info:** this requires to disable `requiretty` in sudo options
