# ActiveRecordRelationships
module Trnsfr
  module Acts #:nodoc:
    module Related #:nodoc:
      
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        
        def belongs_to_resource(model, options={})
          model, klass = model, model.to_s.modelize
          define_method(model) do |*args|
            begin
              return super
            rescue
              options = args.empty? ? [] : args
              klass.find(self.send("#{model}_id"), options.first)
            end
          end
        end
        

        def has_many_resources(model, options={})
          klass = model.to_s.singularize.modelize
          define_method(model) do |*args|
            begin
              return super
            rescue
              set_common_has_many_options(klass, args)
              @assoc_klass.find(:all, @options)
            end
          end
        end
        
      end
      
      
      def set_common_has_many_options(*args)
        @assoc_klass, @options, @self_klass = args.first, (args.last.first || {}), self.class.to_s.singularize.downcase
        @options = @options[:params] if @options[:params]
        return @options = {:params => @options.merge!(:"#{@self_klass}_id" => self.id)} if @assoc_klass.superclass.eql?(ActiveResource::Base)
        @options.merge!(:conditions => "#{@self_klass}_id = #{self.id}")
      end
      
    end
  end
end
