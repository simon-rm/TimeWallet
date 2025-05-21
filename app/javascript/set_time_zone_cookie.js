const KEY = 'time_zone';
const tzName = Intl.DateTimeFormat().resolvedOptions().timeZone;

// Grab current value (if any)
const current = document.cookie.match(new RegExp(`(?:^|;\\s*)${KEY}=([^;]*)`))?.[1];

// Write only if missing or changed
if (current !== tzName) {
    document.cookie = [
        `${KEY}=${encodeURIComponent(tzName)}`,
        'path=/',
        'max-age=31536000',   // one year
        'SameSite=Lax'
    ].join(';');
}
