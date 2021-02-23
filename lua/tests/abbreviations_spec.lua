local helpers = require('tests.helpers')

describe('abbreviations', function()
  describe('expansion', function()
    describe('snippets.nvim', function()
      it('expands abbreviations', helpers.clean_buffer('', function()
        require('snippets').use_suggested_mappings(true)
        helpers.insert('\\a<C-k>')
        assert.is.equal('α', vim.fn.nvim_get_current_line())
      end))

      it('does not autoexpand', helpers.clean_buffer('', function()
        require('snippets').use_suggested_mappings(true)
        helpers.insert('\\a')
        assert.is.equal('\\a', vim.fn.nvim_get_current_line())
      end))

      it('expands mid-word', helpers.clean_buffer('', function()
        pending('norcalli/snippets.nvim#17', function()
          require('snippets').use_suggested_mappings(true)
          helpers.insert('(\\a<C-k>')
          assert.is.equal('(α', vim.fn.nvim_get_current_line())
        end)
      end))
    end)
  end)

  describe('programmatic API', function()
    it('provides access to loaded abbreviations', function()
      assert.is.equal('α', require('lean.abbreviations').load()['\\a'])
    end)
  end)
end)
