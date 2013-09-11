# coding: utf-8
module QiniuDirectUploader
  module FormHelper
    def qiniu_uploader_form(options = {}, &block)
      uploader = Uploader.new(options)
      form_tag(uploader.action, uploader.form_options) do
        all_hidden_fields = {}
        all_hidden_fields =  all_hidden_fields.merge uploader.fields

        custom_hidden_fields = {}
        uploader.custom_fields.each do |key,value|
          custom_hidden_fields["x:#{key}"] = value
        end

        all_hidden_fields =  all_hidden_fields.reverse_merge custom_hidden_fields
        #all_hidden_fields = all_hidden_fields.reverse_merge({:ooo=>uploader.return_body})

        all_hidden_fields.map do |name, value|
          hidden_field_tag(name, value)
        end.join.html_safe + capture(&block)
      end
    end
  end
end
