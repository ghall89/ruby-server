<script lang="ts">
	import { goto } from '$app/navigation';
	import { resolve } from '$app/paths';

	import { api } from '$lib/api';
	import { authState } from '$lib/auth.svelte';

	let username = $state('');
	let password = $state('');
	let error = $state('');
	let submitting = $state(false);

	async function handleSubmit(e: Event) {
		e.preventDefault();
		submitting = true;
		error = '';
		try {
			authState.user = await api.signup(username, password);
			goto(resolve('/'));
		} catch (err: any) {
			error = err.message;
		} finally {
			submitting = false;
		}
	}
</script>

<section class="container mt-5">
	<div class="row justify-content-center">
		<div class="col-md-4">
			<h2 class="mb-4">Sign up</h2>
			{#if error}
				<div class="alert alert-danger">{error}</div>
			{/if}
			<form onsubmit={handleSubmit}>
				<div class="mb-3">
					<label class="form-label" for="username">Username</label>
					<input
						class="form-control"
						type="text"
						id="username"
						bind:value={username}
						autocomplete="username"
						required
					/>
				</div>
				<div class="mb-3">
					<label class="form-label" for="password">Password</label>
					<input
						class="form-control"
						type="password"
						id="password"
						bind:value={password}
						autocomplete="new-password"
						required
					/>
					<small class="form-text text-muted">Must be at least 8 characters</small>
				</div>
				<button class="btn btn-primary w-100" type="submit" disabled={submitting}>Sign up</button>
			</form>
			<p class="mt-3 text-center">
				Already have an account?
				<a href="#/login">Log in</a>
			</p>
		</div>
	</div>
</section>
