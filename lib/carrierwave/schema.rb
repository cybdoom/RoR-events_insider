# Cool patch to allow t.image syntax in migrations
module CarrierWave
  module Schema
    IMAGE_PROPERTIES = {name:          :string,
                        content_type:  :string,
                        file_size:     :integer,
                        width:         :integer,
                        height:        :integer}

    def self.included(base)
      ActiveRecord::ConnectionAdapters::Table.send :include, TableDefinition
      ActiveRecord::ConnectionAdapters::TableDefinition.send :include, TableDefinition
      ActiveRecord::ConnectionAdapters::AbstractAdapter.send :include, Statements

      if defined?(ActiveRecord::Migration::CommandRecorder) # Rails 3.1+
        ActiveRecord::Migration::CommandRecorder.send :include, CommandRecorder
      end
    end

    def self.column_name_for(image_name, property_name)
      property_name == :name ? image_name.to_s : "#{image_name}_#{property_name}"
    end

    module Statements
      def add_image(table_name, *image_names)
        if image_names.empty?
          raise ArgumentError, "Please specify image name in your add_image call in your migration."
        end

        options = image_names.extract_options!

        image_names.each do |image_name|
          IMAGE_PROPERTIES.each_pair do |property_name, column_type|
            column_name = Schema.column_name_for(image_name, property_name)
            column_options = options.merge(options[property_name.to_sym] || {})
            add_column(table_name, column_name, column_type, column_options)
          end
        end
      end

      def remove_image(table_name, *image_names)
        if image_names.empty?
          raise ArgumentError, "Please specify image name in your remove_image call in your migration."
        end

        options = image_names.extract_options!

        image_names.each do |image_name|
          IMAGE_PROPERTIES.each_pair do |property_name, column_type|
            column_name = Schema.column_name_for(image_name, property_name)
            column_options = options.merge(options[property_name.to_sym] || {})
            remove_column(table_name, column_name, column_type, column_options)
          end
        end
      end
    end

    module TableDefinition
      def image(*image_names)
        options = image_names.extract_options!
        image_names.each do |image_name|
          IMAGE_PROPERTIES.each_pair do |property_name, column_type|
            column_name = Schema.column_name_for(image_name, property_name)
            column_options = options.merge(options[property_name.to_sym] || {})
            column(column_name, column_type, column_options)
          end
        end
      end
    end

    module CommandRecorder
      def add_image(*args)
        record(:add_image, args)
      end

      private

      def invert_add_image(args)
        [:remove_image, args]
      end
    end
  end

end

ActiveRecord::Base.send(:include, CarrierWave::Schema) if defined?(ActiveRecord)