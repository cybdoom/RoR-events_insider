EventsInsider::Application.config.session_store ActionDispatch::Session::CacheStore,
                                                namespace: 'sessions',
                                                key: '_eventsinsider_session',
                                                expire_after: 60.minutes
