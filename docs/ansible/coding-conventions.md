# Justcoded Ansible Coding Style and Conventions 

## Index
- [1. General conventions](#1-general-conventions)
  * [Coding conventions]()
    * [Best practices](#best-practices)
    * [The beginning of a file](#the-beginning-of-a-file)
    * [The end of a file](#the-end-of-the-file)
    * [Always name tasks](#always-name-tasks)
    * [Boolean variables](#boolean-variables)
    * [Key/value pairs](#keyvalue-pairs)
    * [Order in playbook](#order-in-playbook)
    * [Order in task declaration](#order-in-task-declaration)
    * [Air and tabulators](#air-and-tabulators)
    * [Variable names](#variable-names)
  * [Content Organization](#content-organization)
  * [Directory Layout](#directory-layout)
  * [Alternative Directory Layout](#alternative-directory-layout)
  * [Group And Host Variables](#group-and-host-variables)
  * [Top Level Playbooks Are Separated By Role](#top-level-playbooks-are-separated-by-role)
  * [Always Mention The State](#always-mention-the-state)
  * [Bundling Ansible Modules With Playbooks](#bundling-ansible-modules-with-playbooks)
  * [Whitespace and Comments](#whitespace-and-comments)

## Best practices

Follow [Sample Ansible setup](https://docs.ansible.com/ansible/latest/tips_tricks/sample_setup.html) and use Ansible Lint, see [documentation](https://ansible.readthedocs.io/projects/lint/).

### Why do this?

The guys and girls who created Ansible have a good understanding how playbooks work and where files should reside.
You'll avoid a lot of your own ingenious pitfalls following their best practices.

### So why doesn't my code look like Ansible examples?

Examples in Ansible documentation are inconsistent.
The main reason for this style guide is to have one consistent way of writing Ansible which is easy to read for you and others.

## The beginning of a file

Always start your file with the YAML heading which is `---`.

Please add comments above these lines with descriptions of what this playbook is and an example of how to run it.



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

### Why do this ?

This makes it quick to find out what the playbook does.
Either with opening the file or just using the `head` command.

## The end of the file

Always end the file with a line shift.

### Why do this?

It's just Unix best practices.
It avoids messing up your prompt when you `cat` a file.

## Always name tasks

It is possible to leave off the ‘name’ for a given task, though it is recommended to provide a description about why something is being done instead. This name is shown when the playbook is run.


## Boolean variables

Always use "false" and "true" values for boolean.

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
 Why do this?

Boolean variables may be expressed in a myriad of ways.
`0/1`, `False/True`, `no/yes` and `false/true`.
Even if you have a choice it's good to have a standard: `false/true`. There are a lot of scripting languages who have standardized on the `false/true` variant. Keep to it.


## Key/value pairs

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

Keep to only one standard. In our case **always use the "map" syntax**. This is regardless of how many key/value pairs that exist in a map.

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
 Why do this?

It's **soooo** much easier to read, and not more work to do. As the writer of this document is dyslectic, think of him and others in the same situation. In addition to the readability, it decreases the chance for a merge conflict.

## Variables in Task Names

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
  Reason
  This will help to easily understand log outputs of playbooks.
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

## Omitting Unnecessary Information
While name tasks in a playbook, do not include the name of the role which is currently executed, since Ansible will do this automatically.

**Reason:**
Avoiding the same output twice on the console will prevent confusions.

## Names

All the newly created Ansible roles should follow the name convention using dashes if necessary:
`[company]-[action]-[function/technology]`

✅ ***Good***

```yaml
# good
mycompany-setup-lvm
```

❌ ***Bad***
```yaml
# bad
lvm
```


## Use Modules instead of command or shell
Before using the `command` or `shell` module, verify if there is already a module available which can avoid the usage of raw shell command.

✅ ***Good***

```yaml
# good
- name: install packages
  tasks:
    - name: 'install httpd'
      yum:
        name: 'httpd'
        state: 'present'
```

❌ ***Bad***
```yaml
# bad
- name: install httpd
  tasks:
    - command: "yum install httpd"
```

**Reason:** While raw command could be seen as a security risk in general, another reason to avoid them is the loss of immutability of the ansible playbooks or roles. Ansible cannot verify if a command has been already executed before or not and will therefore execute it every time the playbook is running.

## 🔴 Spacing addons

# Comparing
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

## Playbook File Extension

All Ansible Yaml files should have a .yml extension (and NOT .YML, .yaml etc).

##Vaults

All Ansible Vault files should have a .vault extension (and NOT .yml, .YML, .yaml etc).

## Use Module synchronize Instead of copy for Large Files

## Use Block-Module

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

 Why do this?

A common order makes playbooks consistent and easier to read for your dear colleagues. Think of them when you write.

## Order in task declaration

A task should be declared in this order.

* `name`
* module and the arguments for the module
* arguments for the task in alphabetic order
* `tags` at the bottom

```yaml
---
- name: unhold packages
  ansible.builtin.shell: 'apt-mark -s unhold {{ item }} && apt-mark unhold {{ item }}'
  args:
    executable: /bin/bash
  changed_when: apt_mark_unhold.rc == 0 and "already" not in apt_mark_unhold.stdout
  failed_when: false
  loop: '{{ packages_ubuntu_unhold }}'
  register: apt_mark_unhold
  tags:
    - apt_unhold
---
```

### Why do this?

Reason is the same as "order of playbook". To make tasks more consistent and easier to read. Help your colleagues.

## Air and tabulators

Air, one of the **most important thing** for humans and **for code**! It must be an empty line before `vars`, `pre_tasks`, `roles` and `tasks`, and before each task in the tasks definition. Tabulator stops must be set to two, `2`, spaces.

### Why do this?

This creates a pretty and tidy code which is easy to read, both for dyslectic and non dyslectic people. There is no excuse not to do this.

## Variable names

Always use `snake_case` for variable names.

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
 Why do this?

Ansible already uses `snake_case` for variables in it's examples. Consistent naming of variables keeps the code tidy and gives better readability.

## Content Organization

Your usage of Ansible should fit your needs, however, not ours, so feel free to modify this approach and organize as you see fit.

Always try to use Ansible’s “roles” to organize your playbook content  organization feature.

## Directory Layout

The top level of the directory would contain files and directories like so:

```text
production                # inventory file for production servers
staging                   # inventory file for staging environment

group_vars/
  group1.yml              # here we assign variables to particular groups
  group2.yml
host_vars/
  hostname1.yml           # here we assign variables to particular systems
  hostname2.yml

library/                  # if any custom modules, put them here (optional)
  module_utils/           # if any custom module_utils to support modules, put them here (optional)
  filter_plugins/         # if any custom filter plugins, put them here (optional)

site.yml                  # master playbook
webservers.yml            # playbook for webserver tier
dbservers.yml             # playbook for dbserver tier

  roles/
    common/               # this hierarchy represents a "role"
      tasks/              #
        main.yml          #  <-- tasks file can include smaller files if warranted
      handlers/           #
        main.yml          #  <-- handlers file
      templates/          #  <-- files for use with the template resource
        ntp.conf.j2       #  <------- templates end in .j2
      files/              #
        bar.txt           #  <-- files for use with the copy resource
        foo.sh            #  <-- script files for use with the script resource
      vars/               #
        main.yml          #  <-- variables associated with this role
      defaults/           #
        main.yml          #  <-- default lower priority variables for this role
      meta/               #
        main.yml          #  <-- role dependencies
      library/            # roles can also include custom modules
      module_utils/       # roles can also include custom module_utils
      lookup_plugins/     # or other types of plugins, like lookup in this case

    webtier/              # same kind of structure as "common" was above, done for the webtier role
    monitoring/           # ""
    fooapp/               # ""
```

## Alternative Directory Layout

Alternatively you can put each inventory file with its group_vars/host_vars in a separate directory. This is particularly useful if your group_vars/host_vars don’t have that much in common in different environments. The layout could look something like this:

```text
inventories/
   production/
      hosts               # inventory file for production servers
      group_vars/
         group1.yml       # here we assign variables to particular groups
         group2.yml
      host_vars/
         hostname1.yml    # here we assign variables to particular systems
         hostname2.yml

   staging/
      hosts               # inventory file for staging environment
      group_vars/
         group1.yml       # here we assign variables to particular groups
         group2.yml
      host_vars/
         stagehost1.yml   # here we assign variables to particular systems
         stagehost2.yml

library/
module_utils/
filter_plugins/

site.yml
webservers.yml
dbservers.yml

roles/
    common/
    webtier/
    monitoring/
    fooapp/
```

This layout gives you more flexibility for larger environments, as well as a total separation of inventory variables between different environments. The downside is that it is harder to maintain, because there are more files.

## Group And Host Variables

Groups are nice for organization, but that’s not all groups are good for.
You can also assign variables to them! For instance, atlanta has its own NTP servers, so when setting up ntp.conf, we should use them.
Let’s set those now:

```yaml
---
# file: group_vars/atlanta
ntp: ntp-atlanta.example.com
backup: backup-atlanta.example.com
```

Variables aren’t just for geographic information either! Maybe the webservers have some configuration that doesn’t make sense for the database servers:

```yaml
---
# file: group_vars/webservers
apacheMaxRequestsPerChild: 3000
apacheMaxClients: 900
```

If we had any default values, or values that were universally true, we would put them in a file called group_vars/all:

```yaml
---
# file: group_vars/all
ntp: ntp-boston.example.com
backup: backup-boston.example.com
```

We can define specific hardware variance in systems in a host_vars file, but avoid doing this unless you need to:

```yaml
---
# file: host_vars/db-bos-1.example.com
foo_agent_port: 86
bar_agent_port: 99
```

Again, if we are using dynamic inventory sources, many dynamic groups are automatically created.
So a tag like “class:webserver” would load in variables from the file “group_vars/ec2_tag_class_webserver” automatically.

## Top Level Playbooks Are Separated By Role

In site.yml, we import a playbook that defines our entire infrastructure. This is a very short example, because it’s just importing some other playbooks:

```yaml
---
# file: site.yml
- import_playbook: webservers.yml
- import_playbook: dbservers.yml
```

In a file like webservers.yml (also at the top level), we map the configuration of the webservers group to the roles performed by the webservers group:

```yaml
---
# file: webservers.yml
- hosts: webservers
  roles:
    - common
    - webtier
```

The idea here is that we can choose to configure our whole infrastructure by “running” site.yml or we could just choose to run a subset by running webservers.yml.
This is analogous to the “–limit” parameter to ansible but a little more explicit:

```yaml
ansible-playbook site.yml --limit webservers
ansible-playbook webservers.yml
```

## Always Mention The State

The ‘state’ parameter is optional to a lot of modules.
Whether ‘state=present’ or ‘state=absent’, it’s always best to leave that parameter in your playbooks to make it clear, especially as some modules support additional states.

## Bundling Ansible Modules With Playbooks

If a playbook has a ./library directory relative to its YAML file, this directory can be used to add ansible modules that will automatically be in the ansible module path.
This is a great way to keep modules that go with a playbook together.
This is shown in the directory structure example at the start of this section.

## Whitespace and Comments

Generous use of whitespace to break things up, and use of comments (which start with ‘#’), is encouraged.

## Optimize Playbook Execution
Disable facts gathering if it is not required.

Try not to use: ansible_facts[‘hostname’] (or ‘nodename’)

Try to use inventory_hostname and inventory_hostname_short instead

It is possible to selectively gather facts (gather_subnet)

Consider caching facts

Increase Parallelism

Ansible runs 1st task on every host, then 2nd task on every host …

Use “forks” (default is 5) to control how many connections can be active (load will increase, try first with conservative values)

While testing forks analize Enable CPU and Memory Profiling

If you use the module "copy" for large files: do not use “copy” module. Use “synchronize” module instead (based on rsync)

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

## Optimize SSH Connections

in `ansible.cfg` set

* ControlMaster
* ControlPersist
* PreferredAuthentications


## Enabling Pipelining

! **Not enabled by default**

reduces number of SSH operations

requires to disable `requiretty` in sudo options

