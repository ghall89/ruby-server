import type { User } from './api'

export const authState: { user: User | null } = $state({ user: null })
