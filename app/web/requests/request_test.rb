class RequestTest < Liza::RequestTest

  test :subject_class do
    assert subject_class == Request
  end

  test :settings do
    assert subject_class.log_level == :normal
    assert subject_class.log_color == :blue
  end

end
