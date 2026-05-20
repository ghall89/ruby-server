<script lang="ts">
	import type { Post } from '../api';

	let { posts }: { posts: Post[] } = $props();
</script>

{#if posts.length === 0}
	<p class="text-muted">No posts yet.</p>
{:else}
	<ul class="list-group">
		{#each posts as post (post.id)}
			<li class="list-group-item d-flex justify-content-between align-items-center">
				<a href={'#/posts/' + post.id}>{post.title}</a>
			</li>
		{/each}
	</ul>
{/if}
