class DashboardController < ApplicationController
    def show
        dashboard
    end

    def dashboard
        @cached_dashboard ||= Dashboard.new
    end

    # expose dashboard to view as a helper method
    helper_method :dashboard
end
