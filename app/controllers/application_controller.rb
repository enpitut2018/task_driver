class ApplicationController < ActionController::Base

	# デバッグ用設定
	# railsへのHTTPリクエストとレスポンスの詳細をログに出力
	# before_action :request_header_log
	# after_action :response_header_log

	# private

 #    def request_header_log
 #    	request.headers.sort.map { |k, v| logger.info "#{k}:#{v}" }
 #    end
 #    def response_header_log
 #    	response.headers.sort.map { |k, v| logger.info "#{k}:#{v}" }
 #    end
end
