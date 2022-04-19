class EndAtValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        return if value.blank?

        # 時間比較をするために文字列に変換
        #   2022-04-18 10:30:00 +0900 → '10:30'
        end_at = (value.hour).to_s + ':' + (value.min).to_s
        if value.sunday?
            record.errors.add(attribute, '日曜日に予約枠は作成不可です')
        elsif !(value.min == 30 || value.min == 00)
            record.errors.add(attribute, '予約枠の終了時間は毎時0分、または30分です')
        elsif value.saturday? && !(end_at >= '11:30' && end_at <= '15:00')
            record.errors.add(attribute, '土曜日の予約枠設定時間は11:00 ~ 15:00です')
        elsif !(end_at >= '10:30' && end_at <= '18:00')
            record.errors.add(attribute, '平日の予約枠設定時間は10:00 ~ 18:00です')
        end
    end
end
