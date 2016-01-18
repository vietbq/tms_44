module UserCoursesHelper
  def course_status course_status
    if course_status == 2
      s = "<span class='label label-success'>" + t("status.status2") + "</span>"
    elsif course_status == 3
      s = "<span class='label label-default'>" + t("status.status3") + "</span>"
    else
      s = "<span class='label label-warning'>" + t("status.status1") + "</span>"
    end
    s.html_safe
  end
end
