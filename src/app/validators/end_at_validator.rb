class EndAtValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        return if value.blank?

        time = value.to_time
        if time.sunday?
            record.errors[attribute] << "日曜日に予約枠は作成不可です"
        elsif !(time.min == 30 || time.min == 00)
            record.errors[attribute] << "予約枠の終了時間は毎時0分、または30分です"
        elsif time.saturday? && !(time.hour >= 11 && time.hour <= 15)
            record.errors[attribute] << "土曜日の予約枠設定時間は11:00 ~ 15:00です"
        elsif !(time.hour >= 10 && time.hour <= 18)
            record.errors[attribute] << "平日の予約枠設定時間は10:00 ~ 18:00です"
        end
    end
end
