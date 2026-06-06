-- name: redeem_invite
-- params: $1 = invite code
-- Atomically consumes one use of an invite only if uses remain.
UPDATE public.invites AS i
SET uses = i.uses + 1
WHERE i.code = $1
  AND i.uses < i.max_uses
RETURNING i.id, i.code, i.uses, i.max_uses;
