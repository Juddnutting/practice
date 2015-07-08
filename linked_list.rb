class Node
	attr_accessor :value, :next_node

	def initialize(value, next_node = nil)
		@value = value
		@next_node = next_node
		puts "initialized node with value #{value}"

	end

end

class LinkedList
	attr_accessor :head

	def initialize(node_val)
		@head = Node.new(node_val, nil)
	end

	def add(value)
		if head.nil?
			head = Node.new(value)
		else
			current = head
			while !current.next_node.nil?
				current = current.next_node
			end
			current.next_node = Node.new(value)
			self
		end
	end

	def display
		current = head
		all_values = []
		while !current.next_node.nil?
			all_values << current.value.to_s
			current = current.next_node
		end
		all_values << current.value.to_s
		puts all_values.join("->")
	end

	def delete(value)
		#if head node is deleted, reroute the head
		if head.value == value
			self.head = @head.next_node
		else
			current = head.next_node
			previous = head
			while current
				if current.value == value
					previous.next_node = current.next_node
					return true
				end
				previous = current
				current = current.next_node
			end
		nil
		end
	end


end

l = LinkedList.new(1)
l.add(2)
l.add(3)
l.display
l.delete(1)
l.delete(3)
l.delete(2)
l.add(5)
l.display