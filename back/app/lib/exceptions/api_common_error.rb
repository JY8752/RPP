# APIで発生する共通エラー
module Exceptions
    class ApiCommonError < StandardError
        attr_accessor(:code)
        attr_accessor(:message)
        attr_accessor(:details)
        attr_accessor(:status)
    
        def set_property(code, message, details, status) 
            @code = code
            @message = message
            @details = details
            @status = status
        end
    end
end