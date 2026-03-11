<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import Header from '@/components/Header.vue'
import Footer from '@/components/Footer.vue'
import Card from '@/components/ui/card/Card.vue'
import CardHeader from '@/components/ui/card/CardHeader.vue'
import CardTitle from '@/components/ui/card/CardTitle.vue'
import CardContent from '@/components/ui/card/CardContent.vue'
import Button from '@/components/ui/button/Button.vue'
import { fetchPosts, type Post } from '@/services/mock'
import { useMockStore } from '@/stores/mock'

const posts = ref<Post[]>([])
const store = useMockStore()

const displayedPosts = computed(() => {
  return posts.value.slice(0, store.counter)
})

onMounted(async () => {
  posts.value = await fetchPosts()
})
</script>

<template>
  <div class="min-h-screen flex flex-col bg-background">
    <Header />

    <main class="flex-1 px-4 py-8">
      <div class="max-w-7xl mx-auto">
        <div class="flex gap-2 mb-6">
          <Button @click="store.decrement">Decrement</Button>
          <span class="flex items-center px-4 py-2 bg-card rounded-lg border">
            Showing: {{ displayedPosts.length }} / {{ posts.length }}
          </span>
          <Button @click="store.increment">Increment</Button>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
          <Card v-for="post in displayedPosts" :key="post.id">
            <CardHeader>
              <CardTitle class="line-clamp-2">{{ post.title }}</CardTitle>
            </CardHeader>
            <CardContent>
              <p class="line-clamp-3 text-sm text-muted-foreground">
                {{ post.body }}
              </p>
            </CardContent>
          </Card>
        </div>
      </div>
    </main>

    <Footer />
  </div>
</template>