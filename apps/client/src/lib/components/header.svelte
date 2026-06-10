<script lang="ts">
	import { resolve } from '$app/paths';
	import { api } from '../api';
	import { authState } from '../auth.svelte';

	async function logout() {
		await api.logout();
		authState.user = null;
	}
</script>

<nav class="navbar navbar-light bg-light border-bottom">
	<div class="container">
		<a href={resolve('/')} class="navbar-brand">App</a>
		<div class="d-flex gap-2 align-items-center">
			{#if authState.user}
				<span class="text-muted">{authState.user.username}</span>
				<button class="btn btn-outline-secondary btn-sm" onclick={logout}>Log out</button>
			{:else}
				<a href={resolve('/login')} class="btn btn-outline-secondary btn-sm">Log in</a>
				<a href={resolve('/signup')} class="btn btn-primary btn-sm">Sign up</a>
			{/if}
		</div>
	</div>
</nav>
