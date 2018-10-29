<?php
/* @var $this SiteController */

$this->pageTitle = Yii::app()->params['name'];
?>

<h1>Welcome to <?php echo Yii::app()->params['name']; ?></h1>

<p>
  Please configure the database that MyT will use, this information can usually be obtained from your webhost.
</p>

<div class="form">
  <?php if (!$error): ?>
    <div class="flash-success">
      Congratulations, you meet all minimum requirements to install MyT!
    </div>
  <?php else: ?>
    <div class="flash-error">
      Sorry, you don't meet the minimum requirements to install MyT, please check your server configuration.
    </div>
  <?php endif; ?>

  <table>
    <thead>
      <tr>
        <th colspan="3">Requirements Check</th>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($requirements as $req): ?>
        <tr>
          <td><?php echo $req[0]; ?></td>
          <?php if ($req[1] && !$req[2]): ?>
            <td><?php echo $req[3]; ?></td>
            <td><?php echo CHtml::image('images/cross.png'); ?></td>
          <?php elseif (!$req[1] && !$req[2]): ?>
            <td><?php echo $req[3]; ?></td>
            <td><?php echo CHtml::image('images/warn.png'); ?></td>
          <?php else: ?>
            <td>&nbsp;</td>
            <td><?php echo CHtml::image('images/tick.png'); ?>
            <?php endif; ?>
        </tr>
      <?php endforeach; ?>
    </tbody>
  </table>

  <?php if (!$error): ?>
    <span class="actions"><?php
      echo CHtml::link('Next &gt;&gt;', array('configureDatabase')),
      CHtml::image('images/actions/server_add.png');
      ?></span>
  <?php endif; ?>

</div>