module ConvertkitV4
  class Client
    module Subscribers
      def subscribers(options = {})
        connection.get("subscribers", options)
      end

      def subscriber(subscriber_id)
        connection.get("subscribers/#{subscriber_id}")
      end

      def add_subscribers(options = {})
        response = connection.post("subscribers") do |f|
          f.body = JSON.generate({
            first_name: options[:first_name],
            email_address: options[:email_address]
          })
        end
        response.body
      end

      def subscriber_tags(subscriber_id)
        connection.get("subscribers/#{subscriber_id}/tags")
      end

      def update_subscriber(subscriber_id, options = {})
        response = connection.put("subscribers/#{subscriber_id}") do |f|
          body = {}
          body[:email_address] = options[:email_address] if options[:email_address]
          body[:fields] = options[:fields] if options[:fields]
          body[:first_name] = options[:first_name] if options[:first_name]

          f.body = JSON.generate(body)
        end
        response.body
      end

      def unsubscribe(email)
        connection.put("unsubscribe") do |f|
          f.params['email'] = email
        end
      end

      def remove_tag_from_subscriber(subscriber_id, tag_id)
        connection.delete("subscribers/#{subscriber_id}/tags/#{tag_id}")
      end
    end
  end
end
