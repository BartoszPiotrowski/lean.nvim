local infoview = require('lean.infoview')

require('tests.helpers').setup {}
describe('infoview', function()
  describe('close_all succeeds', function()
    it('single infoview',
    function(_)
      vim.api.nvim_command("edit temp.lean")
      assert.initclosed.infoview()
      infoview.get_current_infoview():open()
      assert.opened.infoview()

      infoview.close_all()

      assert.closed.infoview()
    end)

    it('multiple infoviews, not all opened',
    function(_)
      vim.api.nvim_command("tabnew")
      assert.buf.created.tracked()
      assert.win.created.tracked()
      vim.api.nvim_command("edit temp1.lean")
      assert.initclosed.infoview()
      infoview.get_current_infoview():open()
      assert.opened.infoview()
      local tab1 = infoview.get_current_infoview().id

      vim.api.nvim_command("tabnew")
      assert.buf.created.tracked()
      assert.win.created.tracked()
      vim.api.nvim_command("edit temp2.lean")
      assert.initclosed.infoview()
      infoview.get_current_infoview():open()
      assert.opened.infoview()
      local tab2 = infoview.get_current_infoview().id

      vim.api.nvim_command("tabnew")
      assert.buf.created.tracked()
      assert.win.created.tracked()
      vim.api.nvim_command("edit temp3.lean")
      assert.initclosed.infoview()
      infoview.get_current_infoview():open()
      assert.opened.infoview()
      infoview.get_current_infoview():close()
      assert.closed_infoview()
      local tab3 = infoview.get_current_infoview().id

      vim.api.nvim_command("tabnew")
      assert.buf.created.tracked()
      assert.win.created.tracked()
      vim.api.nvim_command("edit temp4.lean")
      assert.initclosed.infoview()
      infoview.get_current_infoview():open()
      assert.opened.infoview()
      local tab4 = infoview.get_current_infoview().id

      infoview.close_all()

      assert.closed({tab1, tab2, tab4}).closed_kept({tab3}).infoview()
    end)
  end)
end)