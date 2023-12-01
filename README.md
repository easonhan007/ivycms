# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

### Ruby version

3.1.1

### System dependencies

- devise: single user mode
- rails-i18n: zh-CN and en
- tailwindcss
- daisyui
- sqlite


* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

### cmd

create setting 

```
rails g scaffold setting name url logo ico copyright:text email skype whatsapp phone product_per_page:integer post_per_page:integer recommend_per_page:integer share_code:text email_user_name email_password email_port email_smtp email_receiver email_sender email_active:boolean ga_code:text
```
