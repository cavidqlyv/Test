<?php
/* @var $this SiteController */

$this->pageTitle = Yii::app()->name . ' - Database Creation';
$this->breadcrumbs = array(
    'Database Configuration',
    'Database Creation'
);

$error = false;
?>

<h1>Database Creation</h1>

<p>
  Database configuration worked, now it's time to create the database:
</p>

<div class="form">
  <?php if (Yii::app()->user->hasFlash('install-error')): ?>
    <div class="flash-error">
      <?php $error = true; ?>
      <strong>Error during database creation:</strong>
      <p><?php echo Yii::app()->user->getFlash('install-error'); ?></p>
    </div>
  <?php else: ?>
    <div class="flash-success">
      Database succesfully created, click 'Next' to proceed with the installation.
    </div>	
  <?php endif; ?>

  <ul>
    <?php foreach ($messages as $message): ?>
      <li><?php echo $message; ?></li>
    <?php endforeach; ?>
  </ul>

  <?php if (!$error): ?>
    <span class="actions"><?php
      echo CHtml::link('Next &gt;&gt;', array('ConfigureApp')),
      CHtml::image('images/actions/server_add.png');
      ?></span>
  <?php endif; ?>

</div>