import sentry_sdk

sentry_sdk.init(
    dsn="https://7e577e2219e5d0091002b370c11d420c@o4506268415623168.ingest.sentry.io/4506268443082752",
    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    traces_sample_rate=1.0,
    # Set profiles_sample_rate to 1.0 to profile 100%
    # of sampled transactions.
    # We recommend adjusting this value in production.
    profiles_sample_rate=1.0,
)

division_by_zero = 1 / 0