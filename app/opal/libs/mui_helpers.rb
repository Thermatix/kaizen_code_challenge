module Components
  class Base
    def m_col val
      "mui-col-md-#{val} "
    end

    def m_colof val
      "mui-col-md-offset-#{val} "
    end

    def m_z val
      "mui--z#{val} "
    end

    def m_row
      "mui-row "
    end

    def m_app
      "mui-appbar "
    end

    def m_panel
      "mui-panel "
    end

    def m_button
      "mui-btn "
    end

    def m_b_primary
      "mui-btn mui-btn--primary"
    end

    def m_center
      "mui--text-center "
    end

    def m_align(to)
      "mui--align-#{to} "
    end

    def m_text(to)
      "mui--text-#{to} "
    end

    def m_div(to)
      "mui--divider-#{to} "
    end

    def scrollable
      { overflow: "auto",
        overflowY: "scroll"
      }
    end

    def no_bullets
      {listStyleType: "none"}
    end

  end
end
