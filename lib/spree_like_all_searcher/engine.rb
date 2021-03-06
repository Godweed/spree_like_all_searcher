module SpreeLikeAllSearcher
  class Engine < Rails::Engine
    engine_name 'spree_like_all_searcher'
    
    initializer "spree.spree_like_all_searcher.preferences", :after => "spree.load_preferences" do |app|
      Spree::Config.searcher_class = SpreeLikeAllSearcher::Base
    end
    
    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
    end
    config.autoload_paths += %W(#{config.root}/lib)
    config.to_prepare &method(:activate).to_proc
  end
end