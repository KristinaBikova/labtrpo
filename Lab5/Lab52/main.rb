module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      verb = gets.chomp
      break if verb == 'q'

      action = nil

      if verb == 'GET'
        print 'Choose action (index/show) / q to exit: '
        action = gets.chomp
        break if action == 'q'
      end


      action.nil? ? routes[verb].call : routes[verb][action].call
    end
  end
end

class Post
  attr_accessor :id
  attr_accessor :title
  attr_accessor :author_id
  attr_accessor :content
  
  def initialize(id, title, author_id,content)
    @id = id
    @title = title
    @author_id = author_id
    @content = content
  end

  def show
    puts "Id = #{@id} Title = '#{@title}' Author_id = '#{@author_id}' Content = '#{@content}'"
  end
end

class Comment
  attr_accessor :id
  attr_accessor :author_id
  attr_accessor :content
  
  def initialize(id,author_id,content)
    @id = id
    @author_id = author_id
    @content = content
  end

  def show
    puts "Id = #{@id} Author_id = '#{@author_id}' Content = '#{@content}'"
  end
end

class PostsController
  extend Resource

  def initialize
    @posts = []
  end

  def index
    @posts.each { |post|  post.show} 
  end

  def show
    puts "Id"
    id = gets.chomp
    @posts.each { |post|
      if post.id == id then post.show
      end} 
  end

  def create
    puts "Id"
    id = gets.chomp
    puts "Title"
    title = gets.chomp
    puts "Author_id"
    author_id = gets.chomp
    puts "Content"
    content = gets.chomp

    post = Post.new(id,title,author_id,content)
    @posts.push(post)
  end

  def update
    puts "Id"
    id = gets.chomp
    @posts.each_with_index { |post,index|begin 
      if post.id == id then begin 
        puts "Title"
        title = gets.chomp
        puts "Author_id"
        author_id = gets.chomp
        puts "Content"
        content = gets.chomp
        post = Post.new(id,title,author_id,content)
        @posts[index] = post 
      end
      else puts 'Id not founded'
      end
    end} 
  end

  def destroy
    puts "Id"
    id = gets.chomp
    
    index = @posts.index {|item| item.id.to_i == id.to_i}
    @posts.delete_at(index)
  end
end
      
class CommentsController
  extend Resource

  def initialize
    @comments = []
  end

  def index
    @comments.each { |comment| comment.show} 
  end

  def show
    puts "Id"
    id = gets.chomp
    @comments.each { |comment|begin 
      if comment.id == id then comment.show
      end
    end} 
  end

  def create
    puts "Id"
    id = gets.chomp
    puts "Author_id"
    author_id = gets.chomp
    puts "Content"
    content = gets.chomp

    comment = Comment.new(id,author_id,content)
    @comments.push(comment)
  end

  def update
    puts "Id"
    id = gets.chomp
    @comments.each_with_index { |comment,index|begin 
      if comment.id == id then begin 
        puts "Author_id"
        author_id = gets.chomp
        puts "Content"
        content = gets.chomp
        comment = Comment.new(id,author_id,content)
        @comments[index] = comment
      end
      else puts 'Id not founded'
      end
    end} 
  end

  def destroy
    puts "Id"
    id = gets.chomp
    
    index = @comments.index {|item| item.id.to_i == id.to_i}
    @comments.delete_at(index)
  end
end
      
class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController,  'posts')
    resources(CommentsController,  'comments')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choise = gets.chomp

      PostsController.connection(@routes['posts']) if choise == '1'
      CommentsController.connection(@routes['comments']) if choise == '2'
      break if choise == 'q'
    end

    puts 'Good bye!'
  end

  def resources(klass, keyword)
    controller = klass.new
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
  end
end

router = Router.new

router.init
