# coding: utf-8

require 'jquery-fileupload-rails' if defined?(Rails)

require "qiniu_direct_uploader/version"
require "qiniu_direct_uploader/uploader"
require "qiniu_direct_uploader/form_helper"

require 'qiniu_direct_uploader/engine' if defined?(Rails)

ActionView::Base.send(:include, QiniuDirectUploader::FormHelper) if defined?(ActionView::Base)
