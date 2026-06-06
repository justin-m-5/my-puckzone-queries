-- name: update_last_seen
-- params: $1 = profile UUID
UPDATE public.profiles AS p
SET last_seen_at = now()
WHERE p.id = $1
RETURNING p.id, p.last_seen_at;
