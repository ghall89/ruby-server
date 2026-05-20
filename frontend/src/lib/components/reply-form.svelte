<script lang="ts">
  import { api, type Reply } from './api'

  let {
    postId,
    parentId,
    onReply,
  }: {
    postId: number
    parentId: number | null
    onReply: (reply: Reply) => void
  } = $props()

  let body = $state('')
  let error = $state('')
  let submitting = $state(false)

  async function handleSubmit(e: Event) {
    e.preventDefault()
    if (!body.trim()) return
    submitting = true
    error = ''
    try {
      const reply = await api.createReply(postId, parentId, body)
      body = ''
      onReply(reply)
    } catch (err: any) {
      error = err.message
    } finally {
      submitting = false
    }
  }
</script>

<form onsubmit={handleSubmit} class="mb-4">
  {#if error}
    <div class="alert alert-danger">{error}</div>
  {/if}
  <div class="mb-3">
    <textarea bind:value={body} class="form-control" rows="3" placeholder="Write a reply..."></textarea>
  </div>
  <button type="submit" class="btn btn-primary" disabled={submitting}>Reply</button>
</form>
