module SessionModule
    def log_in(user)
        visit login_path
        fill_in 'Name', with: user.name
        click_button "ログイン"
    end
end
