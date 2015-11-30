Rails.application.config.session_store :cookie_store,
                                       key: '_eventsinsider_session',
                                       expire_after: 60.minutes
