# frozen_string_literal: true

Dir.glob(Rails.root.join('app/rpc_stubs/**/*_services_pb.rb')).each do |f| require f end
