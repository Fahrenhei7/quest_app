module MissionsHelper

  def status_label(status)
    label_class = case status
                  when 'solved'
                    'success'
                  when 'active'
                    'primary'
                  when 'locked'
                    'danger'
                  end
    "<span class='label label-#{label_class}'> #{status} </span>"
  end
end
