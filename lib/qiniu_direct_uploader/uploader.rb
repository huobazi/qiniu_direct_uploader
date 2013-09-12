# coding: utf-8
module QiniuDirectUploader
  class Uploader
    def initialize(options)
      @options = options.reverse_merge(
        expires_in:         360,
        ssl:                false,
        custom_fields:      {},
        submit_button_id:   nil,
        progress_bar_id:    nil,
        drop_paste_zone_id: nil,
        callback_method:    "POST"
      )
    end

    def form_options
      {
        id:                 @options[:id],
        class:              @options[:class],
        method:             "post",
        authenticity_token: false,
        multipart:          true,
        data: {
          callback_url:     @options[:callback_url],
          callback_method:  @options[:callback_method],
          submit_button_id: @options[:submit_button_id],
          drop_paste_zone_id: @options[:drop_paste_zone_id],
          progress_bar_id:  @options[:progress_bar_id]
        }.reverse_merge(@options[:data] || {})
      }
    end

    def fields
      {
        key: key,
        token: @options[:token] || token
      }
    end

    def custom_fields
      @options[:custom_fields]
    end

    def default_key
      "uploads/{timestamp}-{unique-id}-#{SecureRandom.hex}-{filename}"
    end

    def key
      return @options[:key] if @options[:key]
      return  default_key
    end

    def action
      @options[:action] || "http#{@options[:ssl] ? 's' : ''}://up.qiniu.com/"
    end

    def return_body
      fields_array = []
      fields_array.push '"etag": $(etag)'
      fields_array.push '"fname": $(fname)'
      fields_array.push '"fsize": $(fsize)'
      fields_array.push '"mimeType": $(mimeType)'
      fields_array.push '"imageInfo": $(imageInfo)'
      fields_array.push '"exif": $(exif)'
      fields_array.push '"endUser": $(endUser)'
      fields_array.push '"key": $(key)'

      custom_fields_array = []
      @options[:custom_fields].each do |k,v|
        custom_fields_array.push '"' + k.to_s + '": $(x:'+ k.to_s + ')'
      end
      custom_fields_json = '"custom_fields": {' + custom_fields_array.join(',') + '}'

      fields_array.push custom_fields_json

      '{'+ fields_array.join(',') +'}'
    end

    def token
      Qiniu::RS.generate_upload_token scope: @options[:bucket],
        escape: 1,
        expires_in: @options[:expires_in],
        return_body: return_body,
        customer: @options[:customer]
    end
  end
end
