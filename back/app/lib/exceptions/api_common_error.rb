# APIで発生する共通エラー
module Exceptions
    class ApiCommonError < StandardError
        attr_accessor(:code)
        attr_accessor(:message)
        attr_accessor(:details)
        attr_accessor(:status)
    
        def initialize(code, message, details: nil, status: 400) 
            @code = code
            @message = message
            @details = details
            @status = status
        end
    end
end