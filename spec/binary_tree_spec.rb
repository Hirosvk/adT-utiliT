require "rspec"
require "adt_utilit/binary_tree"

describe BinaryTree do
  let!(:tree_node_1){ BinaryTreeNode.new(1) }
  let!(:tree_node_2){ BinaryTreeNode.new(2) }
  let!(:tree_node_3){ BinaryTreeNode.new(3) }
  let!(:tree_node_4){ BinaryTreeNode.new(4) }
  let!(:tree_node_5){ BinaryTreeNode.new(5) }
  let!(:tree_node_6){ BinaryTreeNode.new(6) }
  let!(:tree_node_7){ BinaryTreeNode.new(7) }

  before(:each) {
    tree_node_1.connect(tree_node_2)
    tree_node_2.connect(tree_node_3)
    tree_node_2.connect(tree_node_4)
    tree_node_1.connect(tree_node_5)
    tree_node_5.connect(tree_node_6)
  }
  subject(:tree) { BinaryTree.new(tree_node_1) }

  describe "#initialize" do
    it "when given a BinaryTreeNode, sets the node as root" do
      expect(tree.root).to be(tree_node_1)
    end

    it "When given a root with children, it updates @last on initialize" do
      expect(tree).to receive(:get_last)
      BinaryTree.new(tree_node_1)
    end

    it "when given other object, it creates the root node with the argument" do
      expect(tree.root.value).to be("hooray")
    end
  end

  describe "#get_last" do
    it "returns the node to which next will be added" do
      expect(tree.last).to be(tree_node_5)
    end
  end

  describe "#insert_to_last" do
    it "connects the node to the end of the tree" do
      tree.insert_to_last(tree_node_7)
      expect(tree.dfs(7)).to_not eq(nil)
    end

    it "updates the @last" do
      expect(tree).to receive(:get_last)
      tree.insert_to_last(tree_node_7)
    end
  end

  describe "#bfs" do
    let(:tree) { BinaryTree.new(tree_node_1) }
    it "searches the value, and returns the node" do
      result = tree.bfs(4)
      expect(result).to be(tree_node_4)
    end

    it "searches the condition, and returns the first node" do
      result = tree.bfs{ |val| val % 5 == 0 }
      expect(result).to be(tree_node_5)
    end

    it "searches the closest node to the beginning node" do
      result = tree.bfs{ |val| val > 3 && val < 6 }
      expect(result).to be(tree_node_5)
    end

    it "returns nil if no node was found" do
      result = tree.bfs(10)
      expect(result).to eq(nil)
    end

    it "raises error unless value or block is given" do
      expect{ tree.bfs(4){|val| val > 3} }.to raise_error("Wrong number of argument")
      expect{ tree.bfs }.to raise_error("Wrong number of argument")
    end

  end

  describe "#trav_in_order" do
    let(:tree) { BinaryTree.new(tree_node_1) }
    it "searches the value, and returns the GraphNode" do
      result = tree.trav_in_order(4)
      expect(result).to be(tree_node_4)
    end

    it "searches the condition, and returns the first GraphNode" do
      result = tree.trav_in_order{ |val| val % 5 == 0 }
      expect(result).to be(tree_node_5)
    end

    it "returns nil if no node was found" do
      result = tree.trav_in_order(10)
      expect(result).to eq(nil)
    end

    it "raises error unless value or block is given" do
      expect{ tree.trav_in_order(4){|val| val > 3} }.to raise_error("Wrong number of argument")
      expect{ tree.trav_in_order }.to raise_error("Wrong number of argument")
    end

    it "searches the node in the right order" do
      result = tree.trav_in_order{|val| val > 1}
      expect(result).to be(tree_node_3)
      result = tree.trav_in_order{|val| val % 2 == 0}
      expect(result).to be(tree_node_2)
    end

  end


  #full?
  #perfect?
  #complete?
end