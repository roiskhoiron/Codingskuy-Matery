package game.codingskuy_kotlin

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform