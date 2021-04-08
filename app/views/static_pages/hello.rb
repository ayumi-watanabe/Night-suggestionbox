class Bird
    def title
        yield(:title)
    end
end

class Penguin < Bird
    def title
        provide(:title, 'Penguin')
    end
end